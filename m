Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311035AbSCHTPj>; Fri, 8 Mar 2002 14:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311034AbSCHTPa>; Fri, 8 Mar 2002 14:15:30 -0500
Received: from exchange.macrolink.com ([64.173.88.99]:62222 "EHLO
	exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S311032AbSCHTPV>; Fri, 8 Mar 2002 14:15:21 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D13A76E7@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'David Woodhouse'" <dwmw2@infradead.org>
Cc: "'linux-serial'" <linux-serial@vger.kernel.org>,
        "'linux-kernel'" <linux-kernel@vger.kernel.org>,
        Russell King <rmk@arm.linux.org.uk>
Subject: RE: [PATCH] serial.c procfs kudzu - discussion 
Date: Fri, 8 Mar 2002 11:15:19 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Mar 08, 2002, David Woodhouse wrote:
> 
> Don't forget the fact that non-existent ports are visible, you 
> can open their device nodes, etc. That's just screwed. 

David,

Care to submit a patch or propose a specific method, for discussion?

Ed Vance

---------------------------------------------------------------- 
Ed Vance              serial24@macrolink.com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------

