Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265841AbUALAlg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 19:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265842AbUALAlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 19:41:36 -0500
Received: from 66-95-121-230.client.dsl.net ([66.95.121.230]:61371 "EHLO
	mail.lig.net") by vger.kernel.org with ESMTP id S265841AbUALAld
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 19:41:33 -0500
Message-ID: <4001ECBE.1020009@lig.net>
Date: Sun, 11 Jan 2004 19:39:26 -0500
From: "Stephen D. Williams" <sdw@lig.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tabris <tabris@tabris.net>
Cc: "Hunt, Adam" <ahunt@solvone.com>, linux-kernel@vger.kernel.org
Subject: High Quality Random sources, was: Re: SecuriKey
References: <5117BFF0551DD64884B32EE8CA57D3DB01548A3F@revere.nwpump.com> <200401111446.27403.tabris@tabris.net>
In-Reply-To: <200401111446.27403.tabris@tabris.net>
Content-Type: multipart/mixed;
 boundary="------------040206000607010908050108"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040206000607010908050108
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Impossible?  I think not.  Some "mechanical" devices do exhibit true 
random capability, especially when enhanced by algorithmic means.
To wit:  http://www.lavarand.org/

Let me know if you can prove their methods don't provide a true "high 
quality" random source.

I'd like to see their code as a module with an automatic test to make 
sure that the random source is high quality.  In this case, that would 
mean making sure that the cap was not off the camera.

sdw

tabris wrote:

>...
>	I should also mention that the problem with 'generating' an OTP via any 
>mechanical or algorithmic means is impossible as at best an OTP will only 
>be pseudo-random, and therefore with identical inputs (assuming it is 
>possible, which we can assume here for the sake of theory and security), 
>the same OTP can be generated, thus breaking our assumption/necessity of 
>non-deterministic output.
>
>	I'd say more but I'm on my way to work.
>- --
>tabris
>- -
>I do not know whether I was then a man dreaming I was a butterfly, or
>whether I am now a butterfly dreaming I am a man.
>		-- Chuang-tzu
>-----BEGIN PGP SIGNATURE-----
>Version: GnuPG v1.2.3 (GNU/Linux)
>
>iD8DBQFAAagR1U5ZaPMbKQcRAmo2AJ0Wc6xTLCd/swZYlEO6emktLhOtRgCfUUP5
>OB4YFi6bh1yrVMzGIoN6XNs=
>=O/uT
>-----END PGP SIGNATURE-----
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>


-- 
swilliams@hpti.com http://www.hpti.com Personal: sdw@lig.net http://sdw.st
Stephen D. Williams 703-724-0118W 703-995-0407Fax 20147-4622 AIM: sdw


--------------040206000607010908050108
Content-Type: text/x-vcard; charset=utf8;
 name="sdw.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="sdw.vcf"

begin:vcard
fn:Stephen Williams
n:Williams;Stephen
org:High Performance Technologies, Inc.
adr:;;43392 Wayside Circle;Ashburn;VA;20147;US
email;internet:sdw@lig.net
title:Senior Technical Director
tel;work:703-724-0118
tel;fax:703-995-0407
tel;pager:sdwpage@lig.net
tel;home:703-729-5405
tel;cell:703-371-9362
x-mozilla-html:FALSE
url:http://www.hpti.com
version:2.1
end:vcard


--------------040206000607010908050108--
