Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751035AbWANL5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbWANL5r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 06:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751041AbWANL5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 06:57:47 -0500
Received: from uproxy.gmail.com ([66.249.92.192]:7722 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751030AbWANL5q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 06:57:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type;
        b=MpD4YILP8PIvxZSoo97KapxUaxKppf9mbkmgHLtPqUjGrUgv/x4oYL7475kRqrtgjZ6/W6itn2ZPUkoffqLyzAlSlZ8O0qL8F89p4CSVJu57EexV3l5iiwQiaviSKTKJv/Mpp+0CY7VGozhdgusaRXQ8ycSvUMu08Akd3Ds2buw=
Message-ID: <43C8E735.6080305@gmail.com>
Date: Sat, 14 Jan 2006 12:57:41 +0100
From: Xose Vazquez Perez <xose.vazquez@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH  2.6.15-rc1-git1 1/1] docs: updated some code docs
References: <437CD9C5.6060308@gmail.com> <20051117224619.22649dc5.rdunlap@xenotime.net>
In-Reply-To: <20051117224619.22649dc5.rdunlap@xenotime.net>
Content-Type: multipart/mixed;
 boundary="------------050206080408040103010808"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050206080408040103010808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Randy.Dunlap wrote:

>  Linux USB project:
> -	http://sourceforge.net/projects/linux-usb/
> +	http://linux-usb.sourceforge.net/
> 
> We generally prefer http://www.linux-usb.org/ here.
> 
> 
> +Greg Kroah, "How to piss off a kernel subsystem maintainer".
> 
> That should be Greg Kroah-Hartman.

done against 2.6.15-git10, please apply.

-thanks-

-- 
Politicos de mierda, yo no soy un terrorista.

--------------050206080408040103010808
Content-Type: text/x-patch;
 name="Submitting_code.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Submitting_code.diff"

diff -Nuar a/Documentation/SubmittingDrivers b/Documentation/SubmittingDrivers
--- a/Documentation/SubmittingDrivers	2006-01-14 12:47:02.000000000 +0100
+++ b/Documentation/SubmittingDrivers	2006-01-14 12:50:33.000000000 +0100
@@ -143,7 +143,7 @@
 	http://kernelnewbies.org/
 
 Linux USB project:
-	http://linux-usb.sourceforge.net/
+	http://www.linux-usb.org/
 
 How to NOT write kernel driver by arjanv@redhat.com
 	http://people.redhat.com/arjanv/olspaper.pdf
diff -Nuar a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
--- a/Documentation/SubmittingPatches	2006-01-14 12:47:02.000000000 +0100
+++ b/Documentation/SubmittingPatches	2006-01-14 12:49:58.000000000 +0100
@@ -478,10 +478,11 @@
 Jeff Garzik, "Linux kernel patch submission format."
   <http://linux.yyz.us/patch-format.html>
 
-Greg Kroah, "How to piss off a kernel subsystem maintainer".
+Greg Kroah-Hartman "How to piss off a kernel subsystem maintainer".
   <http://www.kroah.com/log/2005/03/31/>
   <http://www.kroah.com/log/2005/07/08/>
   <http://www.kroah.com/log/2005/10/19/>
+  <http://www.kroah.com/log/2006/01/11/>
 
 NO!!!! No more huge patch bombs to linux-kernel@vger.kernel.org people!.
   <http://marc.theaimsgroup.com/?l=linux-kernel&m=112112749912944&w=2>

--------------050206080408040103010808--
