Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261802AbVGUPmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbVGUPmJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 11:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261803AbVGUPmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 11:42:09 -0400
Received: from upco.es ([130.206.70.227]:37802 "EHLO mail1.upco.es")
	by vger.kernel.org with ESMTP id S261802AbVGUPlL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 11:41:11 -0400
Date: Thu, 21 Jul 2005 17:41:17 +0200
From: Romano Giannetti <romanol@upco.es>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: try acpi -V & acpi -V & acpi -V (was Linux v2.6.13-rc3)
Message-ID: <20050721154117.GB31835@pern.dea.icai.upco.es>
Reply-To: romano@dea.icai.upcomillas.es
Mail-Followup-To: romano@dea.icai.upcomillas.es,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <F7DC2337C7631D4386A2DF6E8FB22B30041AC76D@hdsmsx401.amr.corp.intel.com> <200507211209.46039.rjw@sisk.pl> <20050721153018.GA31835@pern.dea.icai.upco.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050721153018.GA31835@pern.dea.icai.upco.es>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2005 at 05:30:18PM +0200, Romano Giannetti wrote:
> 
> It happens just sometime, bust repeating acpi -V & acpi -V in fast succession 
> it gives a 0% reading in few tries. Kernel is vanilla, no patch applied. 
> 

Sorry to reply to myself. The kernel is configured without preempt. In past
kernels the problem disappeared with preempt (but then my laptop did not
resume from suspend, which is a showstopper). 

Romano

-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569
*** My e-mail has changed, please check your address book
*** Mi dirección de correo ha cambiado, por favor toma nota
*** la mia email è cambiata, per favore modificate la vostra agenda
