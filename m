Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286209AbRLJJz4>; Mon, 10 Dec 2001 04:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286210AbRLJJzq>; Mon, 10 Dec 2001 04:55:46 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:2316 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S286209AbRLJJzf>; Mon, 10 Dec 2001 04:55:35 -0500
Date: Mon, 10 Dec 2001 10:55:31 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
Message-ID: <20011210105531.A4975@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <jcowan@reutershealth.com> <3C0FEE80.2050603@reutershealth.com> <200112071444.fB7EitoH024769@pincoya.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <200112071444.fB7EitoH024769@pincoya.inf.utfsm.cl>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Dec 2001, Horst von Brand wrote:

> > CML2 hacking requires knowing Python; kernel hacking does not.
> 
> CML2 hacking _is_ kernel hacking, if you like to call it such or not.

There is hacking CML2 (the configuration files), and there is hacking
CML2 tools (rule compiler, GUI, ...), only the latter of which requires
Python knowledge.

Python is not that hard too read, and there's always someone you can ask
to explain you some clauses you don't get; and although I've never
looked at the CML2 tools, I looked at fetchmail, and the source has
EXTENSIVE documentation compared to many other projects, so I don't
think Eric did spaghetti (obfuscated) code in his CML2 tools. After all,
it would not be too helpful to counter the goals for CML2 with the very
implementation...
