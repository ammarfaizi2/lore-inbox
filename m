Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbWGLTBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWGLTBQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 15:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbWGLTBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 15:01:16 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:55694 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750765AbWGLTBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 15:01:15 -0400
Subject: Re: tool for measuring interactive responsiveness of the system
	under load ?
From: Arjan van de Ven <arjan@infradead.org>
To: Yakov Lerner <iler.ml@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com
In-Reply-To: <f36b08ee0607121136m1cb31a9ehf735ef67aac3fc1a@mail.gmail.com>
References: <f36b08ee0607121136m1cb31a9ehf735ef67aac3fc1a@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 12 Jul 2006 21:01:12 +0200
Message-Id: <1152730873.3217.65.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-12 at 21:36 +0300, Yakov Lerner wrote:
> I'd like to run a benchmark, a tool that measures responsiveness of
> [simulated]  interactive  program on a loaded system.
> My question is, which program (benchmark) exists for measuring
> the responsiveness [of the kernel under certain load]  to interactive
> usage ?
> 
> Yakov

look at this cool tool:
http://members.optusnet.com.au/ckolivas/interbench/

it's really great!


