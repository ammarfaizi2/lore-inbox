Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263183AbUEKSnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263183AbUEKSnh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 14:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263324AbUEKSng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 14:43:36 -0400
Received: from sampa7.prodam.sp.gov.br ([200.230.190.107]:19983 "EHLO
	sampa7.prodam.sp.gov.br") by vger.kernel.org with ESMTP
	id S263183AbUEKSna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 14:43:30 -0400
Date: Tue, 11 May 2004 15:41:42 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@prefeitura.sp.gov.br>
To: mike <mike@bristolreccc.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problem with sis900 driver 2.6.5 +
Message-ID: <20040511184142.GE12947@lorien.prodam>
Mail-Followup-To: mike <mike@bristolreccc.co.uk>,
	linux-kernel@vger.kernel.org
References: <1084300104.24569.8.camel@datacontrol>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1084300104.24569.8.camel@datacontrol>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hi Mike,

Em Tue, May 11, 2004 at 07:28:24PM +0100, mike escreveu:

| In kernels 2.6.5 and above (may affect 2.6.4 as well) there seems to be
| a problem with the sis900 eth driver
| 
| I have a sis chipset with integrated ethernet sis900 driver which has
| always worked perfectly up to and including 2.6.3 (fedora)
| 
| Now with both fedora 2.6.5 kernel and vanilla 2.6.6 eth0 does not come
| up
| 
| relevant messages
| 
| sis900 device eth0 does not appear to be present delaying initialisation
| 
| and from dmesg eth0: cannot find ISA bridge

 Where you got it ?

| lsmod shows sis and sis900 modules loaded fine

 Is the interface up ?

-- 
Luiz Fernando N. Capitulino
<http://www.telecentros.sp.gov.br>
