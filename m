Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264534AbTDPPpG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 11:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264481AbTDPPpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 11:45:06 -0400
Received: from s161-184-77-200.ab.hsia.telus.net ([161.184.77.200]:29076 "EHLO
	cafe.hardrock.org") by vger.kernel.org with ESMTP id S264492AbTDPPoS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 11:44:18 -0400
Date: Wed, 16 Apr 2003 09:56:02 -0600 (MDT)
From: James Bourne <jbourne@hardrock.org>
To: Michael Clark <michael@metaparadigm.com>
cc: Lincoln Dale <ltd@cisco.com>, Jurjen Oskam <jurjen@quadpro.stupendous.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Booting from Qlogic qla2300 fibre channel card
In-Reply-To: <3E9D7785.5020205@metaparadigm.com>
Message-ID: <Pine.LNX.4.44.0304160952470.1406-100000@cafe.hardrock.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Apr 2003, Michael Clark wrote:

> Hi,
...
> I'm currently looking for alternatives to qlogic HBAs after a year of
> not being able to find a stable driver combo (one that can stand up
> for more than a few weeks). Does any one out there have experience
> with the LSI HBAs and Fusion MPT drivers or perhaps Emulex?

We are currently using the EMC approved 6.04-fo qla2300 driver with great
success.  With multiple connections to a CX600 fail over occurs properly, it
also does failover for the tape drives, and the system has been running for
about 40 days without any problems...

YMMV, but for us it has been working quite well.

Regards
James Bourne


-- 
James Bourne                  | Email:            jbourne@hardrock.org          
Unix Systems Administrator    | WWW:           http://www.hardrock.org
Custom Unix Programming       | Linux:  The choice of a GNU generation
----------------------------------------------------------------------
 "All you need's an occasional kick in the philosophy." Frank Herbert  

