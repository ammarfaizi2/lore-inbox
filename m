Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424178AbWKIWXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424178AbWKIWXa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 17:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424181AbWKIWXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 17:23:30 -0500
Received: from mail1.key-systems.net ([81.3.43.253]:3287 "HELO
	mailer2-1.key-systems.net") by vger.kernel.org with SMTP
	id S1424178AbWKIWXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 17:23:30 -0500
Message-ID: <4553AA5E.7090206@scientia.net>
Date: Thu, 09 Nov 2006 23:23:26 +0100
From: Christoph Anton Mitterer <calestyo@scientia.net>
User-Agent: Icedove 1.5.0.7 (X11/20061014)
MIME-Version: 1.0
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
CC: linux-kernel@vger.kernel.org, Roger Heflin <rheflin@atipa.com>
Subject: Re: Strange write errors on FAT32 partition (maybe an FAT32 bug?!)
References: <4550A481.2010408@scientia.net> <87psbzrss2.fsf@duaron.myhome.or.jp>
In-Reply-To: <87psbzrss2.fsf@duaron.myhome.or.jp>
Content-Type: multipart/mixed;
 boundary="------------030102050108020404040305"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030102050108020404040305
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

OGAWA Hirofumi wrote:
> Christoph Anton Mitterer <calestyo@scientia.net> writes:
>
>   
>> The strange thing is that one time the differences were found directly
>> after copying (thus one would thing RAM is damaged, because the data was
>> probalby (I cannot tell this for sure) taken from file cache).
>> and the other time after restarting with a certainly empty file cache.
>>
>> Any ideas? I'm willing to help debugging and so on but I must admit that
>> I need someone to say me what to do :D
>>     
>
> bit interesting. Could you send the output of diff? I'd like to see
> how it's breaking.
>   
I have now such a diff,... but where should I send it,.. it's quite big
(21266 bytes)

Regards,
Chris.

--------------030102050108020404040305
Content-Type: text/x-vcard; charset=utf-8;
 name="calestyo.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="calestyo.vcf"

YmVnaW46dmNhcmQNCmZuOk1pdHRlcmVyLCBDaHJpc3RvcGggQW50b24NCm46TWl0dGVyZXI7
Q2hyaXN0b3BoIEFudG9uDQplbWFpbDtpbnRlcm5ldDpjYWxlc3R5b0BzY2llbnRpYS5uZXQN
CngtbW96aWxsYS1odG1sOlRSVUUNCnZlcnNpb246Mi4xDQplbmQ6dmNhcmQNCg0K
--------------030102050108020404040305--
