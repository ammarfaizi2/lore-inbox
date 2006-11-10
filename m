Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424300AbWKJApV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424300AbWKJApV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 19:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965733AbWKJApV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 19:45:21 -0500
Received: from mail1.key-systems.net ([81.3.43.253]:3034 "HELO
	mailer2-1.key-systems.net") by vger.kernel.org with SMTP
	id S966066AbWKJApS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 19:45:18 -0500
Message-ID: <4553CB9B.3040901@scientia.net>
Date: Fri, 10 Nov 2006 01:45:15 +0100
From: Christoph Anton Mitterer <calestyo@scientia.net>
User-Agent: Icedove 1.5.0.7 (X11/20061014)
MIME-Version: 1.0
To: Roger Heflin <rheflin@atipa.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Strange write errors on FAT32 partition (maybe an FAT32 bug?!)
References: <4550A481.2010408@scientia.net> <87psbzrss2.fsf@duaron.myhome.or.jp> <4553744E.3050007@scientia.net> <45539188.5080607@atipa.com> <45539366.7070809@scientia.net> <45539588.7020504@atipa.com> <45539699.40105@scientia.net> <45539753.7060906@atipa.com> <4553A461.4080002@scientia.net> <4553A57C.5070503@atipa.com> <4553A6C9.4010906@scientia.net> <4553A84B.9050706@atipa.com> <4553AA8A.5080705@scientia.net> <4553AD1F.4050206@atipa.com> <4553ADF5.3070002@scientia.net> <4553AEE8.8080003@atipa.com>
In-Reply-To: <4553AEE8.8080003@atipa.com>
Content-Type: multipart/mixed;
 boundary="------------060103030206090609050603"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060103030206090609050603
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Roger Heflin wrote:
> Usually it seemed to be IO related, the sums just happened
> to show it issue.   It did not seem to be a cpu issue,
> something unknown outside of the cpu seemed to cause it.
>   
Ok,.. as this is obviously not FAT32 related (just tested the whole
stuff on ext3) I'll open a new thread to hopefully attract more people
for help :-)

btw: right now I'm going to try the whole thing with the edac_mc with
ECC for K8.
mcelog did not return anything at all (just silently quitted).

Thanks so far and regards,
Chris.

--------------060103030206090609050603
Content-Type: text/x-vcard; charset=utf-8;
 name="calestyo.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="calestyo.vcf"

YmVnaW46dmNhcmQNCmZuOk1pdHRlcmVyLCBDaHJpc3RvcGggQW50b24NCm46TWl0dGVyZXI7
Q2hyaXN0b3BoIEFudG9uDQplbWFpbDtpbnRlcm5ldDpjYWxlc3R5b0BzY2llbnRpYS5uZXQN
CngtbW96aWxsYS1odG1sOlRSVUUNCnZlcnNpb246Mi4xDQplbmQ6dmNhcmQNCg0K
--------------060103030206090609050603--
