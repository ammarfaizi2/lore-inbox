Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262399AbUCWJmf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 04:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbUCWJmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 04:42:35 -0500
Received: from upco.es ([130.206.70.227]:23701 "EHLO mail1.upco.es")
	by vger.kernel.org with ESMTP id S262399AbUCWJmd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 04:42:33 -0500
Date: Tue, 23 Mar 2004 10:42:26 +0100
From: Romano Giannetti <romano@dea.icai.upco.es>
To: acpi-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ACPI] AC adapter status wrong after resume (swsusp, pmdsik)
Message-ID: <20040323094226.GA6911@pern.dea.icai.upco.es>
Reply-To: romano@dea.icai.upco.es
Mail-Followup-To: Romano Giannetti <romano@dea.icai.upco.es>,
	acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20040322154654.GA10305@pern.dea.icai.upco.es> <20040322223145.GA2549@luna.mooo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20040322223145.GA2549@luna.mooo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2004 at 12:31:45AM +0200, Micha Feigin wrote:
> On Mon, Mar 22, 2004 at 04:46:54PM +0100, Romano Giannetti wrote:

> >       Iam an user of linux 2.6.x on a Vaio FX701 laptop. I found a little
> >       problem with AC charger status and the suspend/resume software, and so
> >       I copy this message to your list, after a kernel developer suggested
> >       me to do so. 

> I saw this same problem with swsusp2. The solution was to compile the
> battery support as a module, unload it before suspend and reload it
> after resume.

Well... I will try and do it, bur really it seems to me more a workaround
than a solution... nevertheless, thank you very much. 

       Romano 


-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569
