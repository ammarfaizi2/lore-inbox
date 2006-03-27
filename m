Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750833AbWC0THw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbWC0THw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 14:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbWC0THw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 14:07:52 -0500
Received: from ic0245.upco.es ([130.206.70.245]:48782 "EHLO
	antispam.upcomillas.es") by vger.kernel.org with ESMTP
	id S1750833AbWC0THv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 14:07:51 -0500
Date: Mon, 27 Mar 2006 21:08:26 +0200
From: Romano Giannetti <romanol@upcomillas.es>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: ALPS stop worked between 2.6.13 and 2.6.16
Message-ID: <20060327190826.GA18193@pern.dea.icai.upcomillas.es>
Mail-Followup-To: Romano Giannetti <romanol@upcomillas.es>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
References: <20060327153624.GC8679@pern.dea.icai.upcomillas.es> <d120d5000603270805u40916079ufe12eb22d478c954@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <d120d5000603270805u40916079ufe12eb22d478c954@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Mar 27, 2006 at 11:05:26AM -0500, Dmitry Torokhov wrote:

> Hi,
> 
> According to your dmesg your ALPS touchpas awas successfully detected
> by the kernel. Please make sure that you have updated udev package.
> 

Udev is 054 (as per Mandriva 2005). Is that the culprit?
Thanks,

    Romano

-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569
http://www.dea.icai.upcomillas.es/romano/

--
La presente comunicación tiene carácter confidencial y es para el exclusivo uso del destinatario indicado en la misma. Si Ud. no es el destinatario indicado, le informamos que cualquier forma de distribución, reproducción o uso de esta comunicación y/o de la información contenida en la misma están estrictamente prohibidos por la ley. Si Ud. ha recibido esta comunicación por error, por favor, notifíquelo inmediatamente al remitente contestando a este mensaje y proceda a continuación a destruirlo. Gracias por su colaboración.

This communication contains confidential information. It is for the exclusive use of the intended addressee. If you are not the intended addressee, please note that any form of distribution, copying or use of this communication or the information in it is strictly prohibited by law. If you have received this communication in error, please immediately notify the sender by reply e-mail and destroy this message. Thank you for your cooperation. 
