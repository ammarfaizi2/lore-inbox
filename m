Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277196AbRJIRuR>; Tue, 9 Oct 2001 13:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277872AbRJIRuI>; Tue, 9 Oct 2001 13:50:08 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:45061 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S277196AbRJIRtv>; Tue, 9 Oct 2001 13:49:51 -0400
Date: Tue, 9 Oct 2001 14:28:07 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: mtassinari@tin.it
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10 oom_killer
In-Reply-To: <20011009174232.TTCM525.fep31-svc.tin.it@[127.0.0.1]>
Message-ID: <Pine.LNX.4.21.0110091427350.5847-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 9 Oct 2001 mtassinari@tin.it wrote:

> I'm setting up a 2.4.10 (final) abi configured platform.
> 
> Running a legacy SCO appl (which heavily stresses the system),
> I systematically get an oom_killer intervention.

This is being fixed in 2.4.11pre series. Could you please try 2.4.11pre6? 

