Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264547AbTDPP4G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 11:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264564AbTDPP4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 11:56:05 -0400
Received: from customer-148-223-196-18.uninet.net.mx ([148.223.196.18]:45701
	"EHLO soltisns.soltis.cc") by vger.kernel.org with ESMTP
	id S264547AbTDPPzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 11:55:35 -0400
From: "jds" <jds@soltis.cc>
To: James Bourne <jbourne@hardrock.org>,
       Michael Clark <michael@metaparadigm.com>
Cc: Lincoln Dale <ltd@cisco.com>, Jurjen Oskam <jurjen@quadpro.stupendous.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Booting from Qlogic qla2300 fibre channel card
Date: Wed, 16 Apr 2003 10:25:41 -0600
Message-Id: <20030416161931.M27152@soltis.cc>
In-Reply-To: <Pine.LNX.4.44.0304160952470.1406-100000@cafe.hardrock.org>
References: <3E9D7785.5020205@metaparadigm.com> <Pine.LNX.4.44.0304160952470.1406-100000@cafe.hardrock.org>
X-Mailer: Open WebMail 1.90 20030212
X-OriginatingIP: 180.175.220.238 (jds)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi:

  We are currently have qlogic qla2200 driver with storage  Hitachi and 
working perfect in linux, boot qlogic or SCSI your define in orden load modules.

  I have two cards Qlogic Fibre Channel in failover to Hitachi

  Regards



---------- Original Message -----------
From: James Bourne <jbourne@hardrock.org>
To: Michael Clark <michael@metaparadigm.com>
Sent: Wed, 16 Apr 2003 09:56:02 -0600 (MDT)
Subject: Re: Booting from Qlogic qla2300 fibre channel card

> On Wed, 16 Apr 2003, Michael Clark wrote:
> 
> > Hi,
> ...
> > I'm currently looking for alternatives to qlogic HBAs after a year of
> > not being able to find a stable driver combo (one that can stand up
> > for more than a few weeks). Does any one out there have experience
> > with the LSI HBAs and Fusion MPT drivers or perhaps Emulex?
> 
> We are currently using the EMC approved 6.04-fo qla2300 driver with great
> success.  With multiple connections to a CX600 fail over occurs 
> properly, it also does failover for the tape drives, and the system 
> has been running for about 40 days without any problems...
> 
> YMMV, but for us it has been working quite well.
> 
> Regards
> James Bourne
> 
> -- 
> James Bourne                  | Email:           
>  jbourne@hardrock.org          Unix Systems Administrator    | WWW:  
>          http://www.hardrock.org Custom Unix Programming       | 
> Linux:  The choice of a GNU generation
> ----------------------------------------------------------------------
>  "All you need's an occasional kick in the philosophy." Frank 
> Herbert  
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-
> kernel" in the body of a message to majordomo@vger.kernel.org More 
> majordomo info at  http://vger.kernel.org/majordomo-info.html Please 
> read the FAQ at  http://www.tux.org/lkml/
------- End of Original Message -------

