Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270676AbTG0FnT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 01:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270677AbTG0FnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 01:43:19 -0400
Received: from dsl-200-55-80-165.prima.net.ar ([200.55.80.165]:9612 "EHLO
	runner.matiu.com.ar") by vger.kernel.org with ESMTP id S270676AbTG0FnS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 01:43:18 -0400
Subject: Re: [TRIVIAL] sanitize power management config menus
From: Matias Alejo Garcia <mat@matiu.com.ar>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030726194651.5e3f00bb.rddunlap@osdl.org>
References: <20030726200213.GD16160@louise.pinerecords.com>
	 <20030726194651.5e3f00bb.rddunlap@osdl.org>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Organization: 
Message-Id: <1059288573.1956.7.camel@runner>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 27 Jul 2003 02:49:33 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-07-26 at 22:46, Randy.Dunlap wrote:
> 2.  APM and ACPI aren't usable together, right?  so should the
> Kconfig file prevent both of them from being enabled?

No. It is good to have both compiled in the kernel and to choose thru
kernel parms which to use, or to have them in modules.

matías
-- 
Matias Alejo Garcia <mat@matiu.com.ar>
