Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751085AbWC0Pfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbWC0Pfr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 10:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWC0Pfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 10:35:47 -0500
Received: from ic0245.upco.es ([130.206.70.245]:16259 "EHLO
	antispam.upcomillas.es") by vger.kernel.org with ESMTP
	id S1751085AbWC0Pfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 10:35:46 -0500
Date: Mon, 27 Mar 2006 17:36:24 +0200
From: Romano Giannetti <romanol@upcomillas.es>
To: linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
Subject: ALPS stop worked between 2.6.13 and 2.6.16
Message-ID: <20060327153624.GC8679@pern.dea.icai.upcomillas.es>
Mail-Followup-To: Romano Giannetti <romanol@upcomillas.es>,
	linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all. I upgraded kernel from 2.6.13-rc3 to 2.6.16 and ALPS touchpad
stopped worked. I have latest release of synaptics drivers, and can confirm
that  exactly the same config results in a working ALPS on old kernel and no
ALPS on newer (same config).
Details here:

http://www.dea.icai.upco.es/romano/linux/vaio-conf/config-2.6.16-ck1-after-boot/laptop-config.html

and

http://www.dea.icai.upco.es/romano/linux/vaio-conf/config-2.6.13-rc3-rg-after-a-bit/




-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569
http://www.dea.icai.upcomillas.es/romano/

--
La presente comunicación tiene carácter confidencial y es para el exclusivo uso del destinatario indicado en la misma. Si Ud. no es el destinatario indicado, le informamos que cualquier forma de distribución, reproducción o uso de esta comunicación y/o de la información contenida en la misma están estrictamente prohibidos por la ley. Si Ud. ha recibido esta comunicación por error, por favor, notifíquelo inmediatamente al remitente contestando a este mensaje y proceda a continuación a destruirlo. Gracias por su colaboración.

This communication contains confidential information. It is for the exclusive use of the intended addressee. If you are not the intended addressee, please note that any form of distribution, copying or use of this communication or the information in it is strictly prohibited by law. If you have received this communication in error, please immediately notify the sender by reply e-mail and destroy this message. Thank you for your cooperation. 
