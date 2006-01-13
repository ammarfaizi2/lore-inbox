Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422810AbWAMShf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422810AbWAMShf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 13:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422817AbWAMShf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 13:37:35 -0500
Received: from mail.summitinstruments.com ([66.132.4.236]:10690 "EHLO
	mail2.visn.net") by vger.kernel.org with ESMTP id S1422810AbWAMShe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 13:37:34 -0500
Message-ID: <43C7F35A.9010703@summitinstruments.com>
Date: Fri, 13 Jan 2006 13:37:14 -0500
From: "Arne R. van der Heyde" <vanderHeydeAR@summitinstruments.com>
Organization: Summit Instruments, Inc.
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
To: linux-kernel@vger.kernel.org
CC: c-d.hailfinger.kernel.2004@gmx.net
Subject: no carrier when using forcedeth on MSI K8N Neo4-F
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=------------070809070606020204000203
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--------------070809070606020204000203
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I am trying to connect two identical MSI K8N Neo4-F servers with NVIDIA 
nForce4 gigabit Lan ports. When the two ports are connected together via 
a crossover cable, neither computer is able to detect a carrier on the 
Lan ports and are not able to communicate. When either of the nForce4 
gigabit port is connected to a Lan port on another computer with a 
different Lan hardware or to a port on a switch the forcedeth drivers 
detect a carrier and are able to communicate.

It appears that the nForce4 Gigabit ports are not generating a carrier. 
Does the nForce4 not provide standard ethernet ports? If they are 
standard ethernet ports, how do I tell forcedeth to generate a carrier? 
Also how do I get forcedeth to run at a Gigabit?

Thanks for any help,

Best regards,
Arne R. van der Heyde
vanderHeydeAR@summitinstruments.com

Summit Instruments Inc.
2236 N. Cleveland-Massillon Rd.
Akron, Ohio 44333-1255  USA

Phone (330)659-3312
Fax   (330)659-3286
www.summitinstruments.com


--------------070809070606020204000203
Content-Type: text/x-vcard; charset=utf-8; name=vanderHeydeAR.vcf
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="vanderHeydeAR.vcf"

begin:vcard
fn:Arne van der Heyde
n:van der Heyde;Arne
org:Summit Instruments, Inc.
adr:;;2236 N Cleveland-Massillon Rd;Akron;OH;44333-1255;USA
email;internet:vanderHeydeAR@SummitInstruments.com
tel;work:(330) 659-3312
tel;fax:(330) 659-3286
x-mozilla-html:FALSE
url:http://www.SummitInstruments.com
version:2.1
end:vcard


--------------070809070606020204000203
Content-Type: text/plain; x-avg=cert; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Content-Description: "AVG certification"

No virus found in this outgoing message.
Checked by AVG Free Edition.
Version: 7.1.371 / Virus Database: 267.14.17/226 - Release Date: 10-Jan-06

--------------070809070606020204000203--
