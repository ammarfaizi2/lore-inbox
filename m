Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289606AbSBJNX4>; Sun, 10 Feb 2002 08:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289619AbSBJNXu>; Sun, 10 Feb 2002 08:23:50 -0500
Received: from ws-han1.win-ip.dfn.de ([193.174.75.150]:27639 "EHLO
	ws-han1.win-ip.dfn.de") by vger.kernel.org with ESMTP
	id <S289606AbSBJNXm>; Sun, 10 Feb 2002 08:23:42 -0500
Date: Sun, 10 Feb 2002 14:24:23 +0100
Message-ID: <vines.sxdD+5GbNwA@SZKOM.BFS.DE>
X-Priority: 3 (Normal)
To: <linux-kernel@vger.kernel.org>
From: <WHarms@bfs.de> (Walter Harms)
Reply-To: <WHarms@bfs.de>
Subject: FIX: pc_keyb.c  in >2.2.17 2.4.x 2.5.x
X-Incognito-SN: 25185
X-Incognito-Version: 5.1.0.84
MIME-Version: 1.0
Content-type: multipart/mixed; boundary="1013347407-MIME-Part-Dividor"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1013347407-MIME-Part-Dividor
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
the "kbd_exists" fix from around 2.3.39 is a bit hard.
disabling the kdb even when a reset succeeds.

The patch contains a fix. The bug itself is still there.

walter

--1013347407-MIME-Part-Dividor
Content-type: application/octet-stream;
              name="pc_keyb.diff"
Content-Disposition: attachment; filename="pc_keyb.diff"
Content-Transfer-Encoding: base64

NTI3YTUyOCw1MzYKPiAKPiAKPiAvKgo+IHRoZSBuZXcgImtiZF9leGlzdHMiIGxvZ2ljIGluIHBj
X2tiZC5jIG1heSBiZSBqdXN0IGNvbXBsZXRlbHkKPiBidWdnZXJlZC4gSXQgdHJpZXMgdG8gbm90
aWNlIHdoZW4gYSBQQy1zdHlsZSBrZXlib2FyZCBpcyBtaXNzaW5nLCBhbmQKPiBhdm9pZCB0cnlp
bmcgdG8gc2V0IHRoZSBsZWRzIG9uIGl0IHdoZW4gbm8ga2V5Ym9hcmQgZXhpc3RzLiAKPiAqLwo+
IAo+IAo1MzFjNTQwLDU0Mgo8IAkJc2VuZF9kYXRhKEtCRF9DTURfRU5BQkxFKTsJLyogcmUtZW5h
YmxlIGtiZCBpZiBhbnkgZXJyb3JzICovCi0tLQo+IAkJaWYgKCBzZW5kX2RhdGEoS0JEX0NNRF9F
TkFCTEUpID4gMCkKPiAJCQkga2JkX2V4aXN0cyA9IDE7CS8qIHJlLWVuYWJsZSBrYmQgaWYgbm8g
ZXJyb3JzICovCj4gCQllbHNlCg==

--1013347407-MIME-Part-Dividor--
