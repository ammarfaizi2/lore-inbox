Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932688AbWHFGFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932688AbWHFGFE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 02:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932689AbWHFGFD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 02:05:03 -0400
Received: from smtp102.rog.mail.re2.yahoo.com ([206.190.36.80]:32351 "HELO
	smtp102.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932688AbWHFGFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 02:05:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=rogers.com;
  h=Received:Subject:From:Reply-To:To:Cc:In-Reply-To:References:Content-Type:Date:Message-Id:Mime-Version:X-Mailer;
  b=GAGUHVxWuERGmQGKNAyFy1GWXP2v1+a7VuiVadC0uLV88OVPLwgOUJOUFseL/bAmSo6eWOATrmgRd14DHm0DsJYtDtEB7gm+pC1H6m1PDj7gHXjN6ozp4qipCBRle4408xsAIydKYo6LnUATzZpySM0KAGZ9HnAg6QwNdSpAoAM=  ;
Subject: Re: register_timer_hook fails on realtime kernel with
	CONFIG_PROFILE_NMI
From: John Kacur <jkacur@rogers.com>
Reply-To: jkacur@rogers.com
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@elte.hu>, john stultz <johnstul@us.ibm.com>,
       Steven Rostedt <rostedt@goodmis.org>, Darren Hart <dvhltc@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1154843977.7027.33.camel@moblin.mtmk.phub.net.cable.rogers.com>
References: <1154843977.7027.33.camel@moblin.mtmk.phub.net.cable.rogers.com>
Content-Type: multipart/mixed; boundary="=-lKMx/M+PhD3c2Szsdfk2"
Date: Sun, 06 Aug 2006 02:05:38 -0400
Message-Id: <1154844338.7027.36.camel@moblin.mtmk.phub.net.cable.rogers.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-lKMx/M+PhD3c2Szsdfk2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


> I have included vstnm.tar.bz2 in case it is of any help examinig the

This time I'll acually include it. :)



--=-lKMx/M+PhD3c2Szsdfk2
Content-Disposition: attachment; filename=vstnm.tar.bz2
Content-Type: application/x-bzip-compressed-tar; name=vstnm.tar.bz2
Content-Transfer-Encoding: base64

QlpoOTFBWSZTWRXBcpgAA7F/sM6wAsB8d/+fLv/fFP///+oAAIYAEAhQA37lKNYooGI1GqAAAAaA
AAAAAAAAAHDQyaaGmRoaZGQZGRoZAYmjJoAyZGIYSKamRpNTU02hpNMhoNBoyBpk0yGmgZHqANAc
NDJpoaZGhpkZBkZGhkBiaMmgDJkYhhJJCbQTTIMKYmhoRoNDQaMgYgDQ0ZpHqfdHSjX9Tn5suYNv
BMh44YENMkCWja2m0yIejcFe2nYyVkSyQIqI1ENJKSSxAtJNLk2ZZP1sPtrT9sUc7SCJFjP3m+O3
865sXUuqy0wIGr2pML6qFhSMSNCOYPJT5V+qymZVEcwNhdzFkS3SLIoHGA1EH326dN3DNCeq73jv
+2Fs5W2Vna6YZ+cYlHrxRl8Y2z+LWb6yjaGE8a4cvJPPyBuqBkk4DQ3tHWZetnOyF1/mGYHNPlZf
tjZuLzlfGtOMqO2B9d6HqGi2CE6ow4UcWkgUMQLtI5tfm6maaOFDEWorJEkXx5d5GEURTgdu/KxD
QcdzmRwSL7JwybnHBwtKIxTFaSlCtQ8GrC2qHRq0wclFiq6YiZSascURNUs09fc0WYhFUQCJskxW
KGlO8Tzugx0IqKM43RTLgRIHEGYtt4/osRuTDlatjih3TAs3+Ncqe8GjtZJhmWhE1Rbi0A5YVj3a
agkcERarOmGPphUkDV3SojZFcYo4KMX5CgeGPJcEJco3Wpr8/Lss18KDIDeb1N6xnNyMP4IgJCVD
oUbfxJiM75MORyD3LgOj+GkKSZ34eRJhjsmkhLT2calTiF4sB1ldzslBMoq1mguxvKZVJQ0tjnpI
rRyVXOivxlGNsFCiYBgoRvGAJZjhXiusVjDGR0sCTFyYhjJSdbAyUKyTEBVbeXCQoH75nD5qdVDS
zWGJEilNSLLegZmK6NKLh4NWMDokbRdgGrqMfOOTVww0i78qsh2Y52EUVZrdYlaVBYrM+N09pY4a
Me/RjHagiCKkcqtlwQVoCVxAJblmMzYQ3xkqNW8qiUwmW3vGWU0Xw47sZZkRahwOzjhFuaSR5ENQ
w0Wq8UonmHPRimcVobcGUZcPRoqKTBGxEjQrUXIC9iv2PpYjAv1UCKGQyxileM48I6caIlRGgLGq
GonWmfuINuWafJbBiFadiO1GFV3pDIOlG16/9r64ns3Xs59CzIymV5eUaVblxA5itUwAP4u5Ipwo
SArguUwA


--=-lKMx/M+PhD3c2Szsdfk2--

