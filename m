Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269099AbUJKPxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269099AbUJKPxW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 11:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269059AbUJKPvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 11:51:22 -0400
Received: from FW-30-241.go.retevision.es ([62.174.241.30]:56485 "EHLO
	mayhem.ghetto") by vger.kernel.org with ESMTP id S269048AbUJKPYR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 11:24:17 -0400
Date: Mon, 11 Oct 2004 17:24:14 +0200
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [BUG] 2.6.9-rc2 scsi and elevator oops when I/O error
Message-ID: <20041011152414.GA5118@larroy.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
References: <20041011050320.GA28703@larroy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041011050320.GA28703@larroy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: piotr@larroy.com (Pedro Larroy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another side problem I have observed about this:
	
Processes that call sync() get stuck into D state, for example shutdown.


-- 
Pedro Larroy Tovar | Linux & Network consultant |  pedro%larroy.com 

Las patentes de programación son nocivas para la innovación
	http://proinnova.hispalinux.es/
