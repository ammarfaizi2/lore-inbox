Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264677AbUFPXtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264677AbUFPXtR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 19:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264669AbUFPXtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 19:49:16 -0400
Received: from fmr99.intel.com ([192.55.52.32]:5080 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S264677AbUFPXs2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 19:48:28 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: more files with licenses that aren't GPL-compatible
Date: Wed, 16 Jun 2004 16:47:34 -0700
Message-ID: <A06801158AE07847B27A52C1A074BC1D04C910B4@fmsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: more files with licenses that aren't GPL-compatible
Thread-Index: AcRT9fmtIQSkdrd0SS+hAqjxlln3wwAAubeQ
From: "Wichmann, Mats D" <mats.d.wichmann@intel.com>
To: "Erik Harrison" <erikharrison@gmail.com>
Cc: <davids@webmaster.com>, <eric@cisu.net>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 16 Jun 2004 23:47:50.0784 (UTC) FILETIME=[55B27800:01C453FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > The kernel's license prohibits
>> > distrubiting it in combination with works that have licenses more
>> > restrictive than the GPL.
>> 
>> That better be bogus, or else vendors are going to be very upset that
>> they can't ship the kernel with, say, trademarked images. For
example,
>> Mozilla's trademark on their artwork is fairly restrictive, or the
>> Mandrake Firewall product (if that's even still around - I don't keep
>> up).

Please keep distinct "ship with" in the sense of /inside/ the
kernel and "ship with" in the sense of on the same distribution
media.  The GPL also has explicit wording for the latter
(you've already been quoted the words on the former):

"In addition, mere aggregation of another work not based on the 
Program with the Program (or with a work based on the Program)
on a volume of a storage or distribution medium does not bring
the other work under the scope of this License. "

I can't imagine anyone putting the Mozilla logo inside the
kernel, but if they do, as mentioned, that's a problem if
its license is not GPL.

-- mats

Normal disclaimers apply: not a lawyer, not speaking on behalf
of my employer, etc. etc.
