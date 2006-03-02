Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbWCBJc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbWCBJc4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 04:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbWCBJc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 04:32:56 -0500
Received: from ic0245.upco.es ([130.206.70.245]:1456 "EHLO
	antispam.upcomillas.es") by vger.kernel.org with ESMTP
	id S932215AbWCBJcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 04:32:55 -0500
Date: Thu, 2 Mar 2006 10:33:33 +0100
From: Romano Giannetti <romanol@upcomillas.es>
To: "Brown, Len" <len.brown@intel.com>
Cc: Dave Jones <davej@redhat.com>, "Raj, Ashok" <ashok.raj@intel.com>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
Subject: Re: 2.6.16rc5 'found' an extra CPU.
Message-ID: <20060302093333.GB18448@pern.dea.icai.upcomillas.es>
Mail-Followup-To: Romano Giannetti <romanol@upcomillas.es>,
	"Brown, Len" <len.brown@intel.com>, Dave Jones <davej@redhat.com>,
	"Raj, Ashok" <ashok.raj@intel.com>, Andi Kleen <ak@suse.de>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
References: <F7DC2337C7631D4386A2DF6E8FB22B30063BFB95@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B30063BFB95@hdsmsx401.amr.corp.intel.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Please bear with me  for jumping in this thread, but I have a related
question: 

On Thu, Mar 02, 2006 at 12:49:53AM -0500, Brown, Len wrote:
> 
> I'm afraid that even after we get this stuff out of /proc
> and into sysfs where it belongs, we'll have to leave /proc/acpi around
> for a while b/c unfortunately people are under the impression
> that the path names there actually mean something and
> they can actually count on them -- which they can't.

Is it possible to obtain the same control/information with sysfs that is
available from /proc/acpi? For example, I use quite extensively CPU
throttling on my VAIO ("cool & quiet home-made mode"), and I was unable to
find the equivalent of /proc/acpi/processor/CPU0/throttling ...

Thanks, 
        Romano 

-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569
http://www.dea.icai.upcomillas.es/romano/

--
La presente comunicación tiene carácter confidencial y es para el exclusivo uso del destinatario indicado en la misma. Si Ud. no es el destinatario indicado, le informamos que cualquier forma de distribución, reproducción o uso de esta comunicación y/o de la información contenida en la misma están estrictamente prohibidos por la ley. Si Ud. ha recibido esta comunicación por error, por favor, notifíquelo inmediatamente al remitente contestando a este mensaje y proceda a continuación a destruirlo. Gracias por su colaboración.

This communication contains confidential information. It is for the exclusive use of the intended addressee. If you are not the intended addressee, please note that any form of distribution, copying or use of this communication or the information in it is strictly prohibited by law. If you have received this communication in error, please immediately notify the sender by reply e-mail and destroy this message. Thank you for your cooperation. 
