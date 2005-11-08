Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964929AbVKHIuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964929AbVKHIuc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 03:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932498AbVKHIuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 03:50:32 -0500
Received: from van-1-67.lab.dnainternet.fi ([62.78.96.67]:34011 "EHLO
	mail.zmailer.org") by vger.kernel.org with ESMTP id S932494AbVKHIuc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 03:50:32 -0500
Date: Tue, 8 Nov 2005 10:50:31 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Mark Knecht <markknecht@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NVidia nForce4 + AMD Athlon64 X2 --> no access to north-bridge PCI resources
Message-ID: <20051108085031.GG5706@mea-ext.zmailer.org>
References: <20051107225755.GE5706@mea-ext.zmailer.org> <5bdc1c8b0511071620o2032c85crd45a4777aae4b971@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bdc1c8b0511071620o2032c85crd45a4777aae4b971@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 04:20:09PM -0800, Mark Knecht wrote:
> On 11/7/05, Matti Aarnio <matti.aarnio@zmailer.org> wrote:
> >
> > This problem machine is  ASUS A8N-SLI Premium
> > AMD CPU family/model/stepping: 15/35/2
> >
> > The question is:
> >
> >   Where are "host bridge" subsystem things in this new
> >   ASUS board with NVidia nForce4 ?
> 
> Interesting. Here's another NForce4 from Asus - A8N-E. It does not
> show the problem you observe:

What processor do you have ?
If anybody with any A8N-SLI variant would see the "host bridge" resources,
then things would be most interesting..


> lightning ~ # lspci
> 0000:00:00.0 Memory controller: nVidia Corporation CK804 Memory Controller (rev a3)
....
> 0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
> 0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
> 0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
> 0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
> 0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV370 5B60 [Radeon X300 (PCIE)]
.... 
> - Mark

  /Matti Aarnio
