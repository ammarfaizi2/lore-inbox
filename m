Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263384AbTDGLZy (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 07:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263385AbTDGLZy (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 07:25:54 -0400
Received: from sol.cc.u-szeged.hu ([160.114.8.24]:39075 "EHLO
	sol.cc.u-szeged.hu") by vger.kernel.org with ESMTP id S263384AbTDGLZv (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 07:25:51 -0400
Date: Mon, 7 Apr 2003 13:37:23 +0200 (CEST)
From: Geller Sandor <wildy@petra.hos.u-szeged.hu>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
cc: linux-kernel@vger.kernel.org
Subject: Re: ext3 features/options
In-Reply-To: <Pine.LNX.4.51.0304071323240.15910@dns.toxicfilms.tv>
Message-ID: <Pine.LNX.4.44.0304071336470.24200-100000@petra.hos.u-szeged.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Apr 2003, Maciej Soltysiak wrote:

> how do i see which features / options filesystem has set ?
> i think tune2fs can only set or clear the flags.

tune2fs -l /dev/...

See 'Filesystem features'.

  Geller Sandor <wildy@petra.hos.u-szeged.hu>

