Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264482AbTDPQhg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 12:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264483AbTDPQhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 12:37:36 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:32270
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S264482AbTDPQhI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 12:37:08 -0400
Subject: Re: RedHat 9 and 2.5.x support
From: Robert Love <rml@tech9.net>
To: Antonio Vargas <wind@cocodriloo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030416165408.GD30098@wind.cocodriloo.com>
References: <20030416165408.GD30098@wind.cocodriloo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1050511742.15637.24.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 16 Apr 2003 12:49:02 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-16 at 12:54, Antonio Vargas wrote:

> I've just installed RedHat 9 on my desktop machine and I'd like
> if it will support running under 2.5.65+ instead of his usual
> 2.4.19+.

Other than modutils(*) there are no issues with RH9 and 2.5.  I am
running RH9 with 2.5 on my daily workstation.

Even NPTL, sysenter, and all the other goodies work flawlessly.  It is
quite nice.

(*) modutils may even work if RH ships the compatibility layer and the
new module tools.  I have no idea, I do not use modules.

	Robert Love

