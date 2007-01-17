Return-Path: <linux-kernel-owner+w=401wt.eu-S1751696AbXAQBMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbXAQBMT (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 20:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751681AbXAQBMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 20:12:19 -0500
Received: from mail1.key-systems.net ([81.3.43.211]:33721 "HELO
	mail1.key-systems.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751659AbXAQBMS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 20:12:18 -0500
Message-ID: <45AD77EE.4070407@scientia.net>
Date: Wed, 17 Jan 2007 02:12:14 +0100
From: Christoph Anton Mitterer <calestyo@scientia.net>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Robert Hancock <hancockr@shaw.ca>, linux-kernel@vger.kernel.org,
       knweiss@gmx.de, ak@suse.de, andersen@codepoet.org, krader@us.ibm.com,
       lfriedman@nvidia.com, linux-nforce-bugs@nvidia.com
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives (k8
 cpu errata needed?)
References: <fa.E9jVXDLMKzMZNCbslzUxjMhsInE@ifi.uio.no> <459C3F29.2@shaw.ca> <45AC06B2.3060806@scientia.net> <45AC08B9.5020007@scientia.net> <45AC1AEB.60805@shaw.ca> <45ACD918.2040204@scientia.net> <45ACE07D.3050207@shaw.ca> <20070116180154.GA1335@tuatara.stupidest.org> <45AD2D00.2040904@scientia.net> <20070116203143.GA4213@tuatara.stupidest.org>
In-Reply-To: <20070116203143.GA4213@tuatara.stupidest.org>
Content-Type: multipart/mixed;
 boundary="------------050608020502020404070403"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050608020502020404070403
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Chris Wedgwood wrote:
> I'd like to here from Andi how he feels about this?  It seems like a
> somewhat drastic solution in some ways given a lot of hardware doesn't
> seem to be affected (or maybe in those cases it's just really hard to
> hit, I don't know).
>   
Yes this might be true,.. those who have reported working systems might
just have a configuration where the error happens even rarer or where
some other event(s) work around it.

>> Well we can hope that Nvidia will find out more (though I'm not too
>> optimistic).
>>     
> Ideally someone from AMD needs to look into this, if some mainboards
> really never see this problem, then why is that?  Is there errata that
> some BIOS/mainboard vendors are dealing with that others are not?
>   
Some time ago I've asked here in a post if some of you could try to
contact AMD and/or Nvidia,.. as no one did,... I wrote them again (to
all forums and email addresses I knew). (You can see the text here
http://www.nvnews.net/vbulletin/showthread.php?t=82909).
Now Nvidia replied and it seems (thanks to Mr. Friedman) that they're
actually try to investigate in the issue...

I received on reply from AMD (actually in German which is strange as I
wrote to their US support)... where they told me they'd have forwarded
my mail to their Linux engineers... but no reply since then.

Perhaps some of you have some "contacts" and can use them...

--------------050608020502020404070403
Content-Type: text/x-vcard; charset=utf-8;
 name="calestyo.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="calestyo.vcf"

YmVnaW46dmNhcmQNCmZuOk1pdHRlcmVyLCBDaHJpc3RvcGggQW50b24NCm46TWl0dGVyZXI7
Q2hyaXN0b3BoIEFudG9uDQplbWFpbDtpbnRlcm5ldDpjYWxlc3R5b0BzY2llbnRpYS5uZXQN
CngtbW96aWxsYS1odG1sOlRSVUUNCnZlcnNpb246Mi4xDQplbmQ6dmNhcmQNCg0K
--------------050608020502020404070403--
