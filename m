Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276591AbRJ2RDm>; Mon, 29 Oct 2001 12:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276576AbRJ2RDc>; Mon, 29 Oct 2001 12:03:32 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:31174 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S276591AbRJ2RDS>; Mon, 29 Oct 2001 12:03:18 -0500
From: Christoph Rohland <cr@sap.com>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.x-ac: No loop on tmpfs
In-Reply-To: <200110291629.f9TGTt6K010692@pincoya.inf.utfsm.cl>
Organisation: SAP LinuxLab
Date: 29 Oct 2001 18:03:20 +0100
Message-ID: <m3r8rmgyzr.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Horst,

On Mon, 29 Oct 2001, Horst von Brand wrote:
> Any fundamental reason for this behaviour, and should RH just use
> /var/tmp or something else? Or is this a simple oversight of some
> sort?

loop needs a feature that tmpfs - for fundamental design reasons -
does not support.

Greetings
		Christoph


