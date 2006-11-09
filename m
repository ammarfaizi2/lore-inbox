Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965992AbWKIWit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965992AbWKIWit (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 17:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966017AbWKIWit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 17:38:49 -0500
Received: from mail1.key-systems.net ([81.3.43.253]:36823 "HELO
	mailer2-1.key-systems.net") by vger.kernel.org with SMTP
	id S965992AbWKIWit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 17:38:49 -0500
Message-ID: <4553ADF5.3070002@scientia.net>
Date: Thu, 09 Nov 2006 23:38:45 +0100
From: Christoph Anton Mitterer <calestyo@scientia.net>
User-Agent: Icedove 1.5.0.7 (X11/20061014)
MIME-Version: 1.0
To: Roger Heflin <rheflin@atipa.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Strange write errors on FAT32 partition (maybe an FAT32 bug?!)
References: <4550A481.2010408@scientia.net> <87psbzrss2.fsf@duaron.myhome.or.jp> <4553744E.3050007@scientia.net> <45539188.5080607@atipa.com> <45539366.7070809@scientia.net> <45539588.7020504@atipa.com> <45539699.40105@scientia.net> <45539753.7060906@atipa.com> <4553A461.4080002@scientia.net> <4553A57C.5070503@atipa.com> <4553A6C9.4010906@scientia.net> <4553A84B.9050706@atipa.com> <4553AA8A.5080705@scientia.net> <4553AD1F.4050206@atipa.com>
In-Reply-To: <4553AD1F.4050206@atipa.com>
Content-Type: multipart/mixed;
 boundary="------------080601000609060904050006"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080601000609060904050006
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Roger Heflin wrote:
> That should mean that it is not a HW pci bus issue, though I
> still have seen odd MB failures that cause corruption and don't
> show anywhere (pci, ecc, mcelog), and only show up with cksums
> on specific pieces of hw.
>
> I don't have any good way of find those, we swapped one part
> at a time until it went quit doing it.
Would those errors also occur when just calculating message digests
(sha1sum)? Because if so,.. I could exclude those types of errors for my
issue because as I've told,.. at least on the original files the sha
sums always are correct.

Regards,
Chris.

--------------080601000609060904050006
Content-Type: text/x-vcard; charset=utf-8;
 name="calestyo.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="calestyo.vcf"

YmVnaW46dmNhcmQNCmZuOk1pdHRlcmVyLCBDaHJpc3RvcGggQW50b24NCm46TWl0dGVyZXI7
Q2hyaXN0b3BoIEFudG9uDQplbWFpbDtpbnRlcm5ldDpjYWxlc3R5b0BzY2llbnRpYS5uZXQN
CngtbW96aWxsYS1odG1sOlRSVUUNCnZlcnNpb246Mi4xDQplbmQ6dmNhcmQNCg0K
--------------080601000609060904050006--
