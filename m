Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262908AbVCDNkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262908AbVCDNkf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 08:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262905AbVCDNke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 08:40:34 -0500
Received: from [209.203.41.250] ([209.203.41.250]:33495 "EHLO
	bventer01.shoden.co.za") by vger.kernel.org with ESMTP
	id S262898AbVCDNjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 08:39:22 -0500
Message-ID: <42286505.2010104@shoden.co.za>
Date: Fri, 04 Mar 2005 15:39:17 +0200
From: Bennie Kahler-Venter <bennie.venter@shoden.co.za>
Reply-To: bennie.venter@shoden.co.za
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dtor_core@ameritech.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: v.2.6.11 mouse still losing sync and thus jumping around
References: <42271D31.8060006@shoden.co.za> <200503031543.53065.dtor_core@ameritech.net> <422822DA.2050501@shoden.co.za>
In-Reply-To: <422822DA.2050501@shoden.co.za>
Content-Type: multipart/mixed;
 boundary="------------000104040009000304000404"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000104040009000304000404
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Find attached the updated psmouse-resend patch for 2.6.11.

It fixes most of the lost-sync problems for the ps2 mouse but not all of 
them.  I might have picked the wrong struct members for v.2.6.11

Tnx & Bi
Bennie Kahler-Venter


--------------000104040009000304000404
Content-Type: application/x-gunzip;
 name="psmouse-resend-2_6_11-v1.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="psmouse-resend-2_6_11-v1.patch.gz"

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
--------------000104040009000304000404--
