Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318501AbSHPONq>; Fri, 16 Aug 2002 10:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318502AbSHPONq>; Fri, 16 Aug 2002 10:13:46 -0400
Received: from moutng.kundenserver.de ([212.227.126.182]:7906 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id <S318501AbSHPONo>; Fri, 16 Aug 2002 10:13:44 -0400
Date: Fri, 16 Aug 2002 16:21:17 +0200
From: Heinz Diehl <hd@cavy.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre2-ac3 stops responding
Message-ID: <20020816142117.GA5412@chiara.cavy.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <3D5CFE83.136D81FC@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D5CFE83.136D81FC@wanadoo.fr>
Organization: private site in Mannheim/Germany
X-PGP-Key: Use PGP! Get my key at http://www.cavy.de/hd.key
User-Agent: Mutt/1.5.1i (Linux 2.4.20-pre2-ac3 i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Aug 16 2002, Jean-Luc Coulon wrote:

> If I have high disk activity, the system stops responding for a while,
> it does not accepts any key action nor mouse movement. It starts running
> normally after few seconds.

Try using Robert Love's "preempt-kernel" and "sched-hints" patches in
addition to -ac3, it helps a lot.

See "ftp://ftp.de.kernel.org/pub/linux/kernel/people/rml/" for the patches.

-- 
# Heinz Diehl, 68259 Mannheim, Germany
