Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290630AbSBFPc5>; Wed, 6 Feb 2002 10:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290627AbSBFPcs>; Wed, 6 Feb 2002 10:32:48 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:32486 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S290624AbSBFPcj>; Wed, 6 Feb 2002 10:32:39 -0500
From: Christoph Rohland <cr@sap.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andries.Brouwer@cwi.nl, hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: How to check the kernel compile options ?
In-Reply-To: <E16YSs7-0005GY-00@the-village.bc.nu>
Organisation: SAP LinuxLab
Date: Wed, 06 Feb 2002 16:31:41 +0100
In-Reply-To: <E16YSs7-0005GY-00@the-village.bc.nu> (Alan Cox's message of
 "Wed, 6 Feb 2002 14:16:27 +0000 (GMT)")
Message-ID: <m3zo2meiea.fsf@linux.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Artificial
 Intelligence, i386-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On Wed, 6 Feb 2002, Alan Cox wrote:
> That is indeed an extremely cunning plan. Paticularly as
> /proc/config can be a symlink to it

Not a symlink, but the implementation. We could make a generic
interface something like proc_make_info_file(name, buffer, length).

Greetings
		Christoph


