Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755157AbWKMQ1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755157AbWKMQ1f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 11:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755196AbWKMQ1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 11:27:35 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:13029 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1755157AbWKMQ1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 11:27:34 -0500
Subject: Re: Dual cores on Core2Duo not detected?
From: Arjan van de Ven <arjan@infradead.org>
To: Shaun Q <shaun@c-think.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>,
       Stephen Clark <Stephen.Clark@seclark.us>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.BSO.4.64.0611130804011.21533@ref.nmedia.net>
References: <Pine.BSO.4.64.0611122322060.30536@ref.nmedia.net>
	 <4558773A.4040803@seclark.us>
	 <Pine.BSO.4.64.0611130752270.21533@ref.nmedia.net>
	 <9a8748490611130803o4dbd05a5w6d271136db5e4378@mail.gmail.com>
	 <Pine.BSO.4.64.0611130804011.21533@ref.nmedia.net>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 13 Nov 2006 17:27:28 +0100
Message-Id: <1163435248.15249.179.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Processor #0 6:15 APIC version 20
> Setting APIC routing to physical flat
> BIOS bug, no explicit IRQ entries, using default mptable. (tell your hw 
> vendor)

hmmm smells like a disabled ACPI, since normally this info comes from
ACPI nowadays, not the mptable




if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

