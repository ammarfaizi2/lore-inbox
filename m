Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261349AbVEQKIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbVEQKIN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 06:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbVEQKIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 06:08:13 -0400
Received: from w240.dkm.cz ([62.24.88.240]:16393 "EHLO mail.spitalnik.net")
	by vger.kernel.org with ESMTP id S261349AbVEQKIG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 06:08:06 -0400
From: Jan Spitalnik <jan@spitalnik.net>
To: Karel Kulhavy <clock@twibright.com>
Subject: Re: software mixing in alsa
Date: Tue, 17 May 2005 12:08:03 +0200
User-Agent: KMail/1.8.50
Cc: linux-kernel@vger.kernel.org
References: <20050517095613.GA9947@kestrel>
In-Reply-To: <20050517095613.GA9947@kestrel>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200505171208.04052.jan@spitalnik.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dne út 17. kvìtna 2005 11:56 Karel Kulhavy napsal(a):
> Hello
>
> http://www.math.tu-berlin.de/~sbartels/alsa/driver/driver.html says
> "For example, there is currently ongoing work to allow mixing multiple
> inputs to the pcm devices."
>

Hi,

yes, ALSA can mix multiple inputs with its dmix plugin.
http://alsa.opensrc.org/index.php?page=DmixPlugin

bye,
	spity

-- 
Jan Spitalnik
jan@spitalnik.net

