Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbTENLgR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 07:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbTENLgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 07:36:17 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:6560
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261840AbTENLgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 07:36:16 -0400
Subject: Re: Digital Rights Management - An idea
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dean McEwan <dean_mcewan@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030514083039.26350.qmail@linuxmail.org>
References: <20030514083039.26350.qmail@linuxmail.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052909440.2102.0.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 May 2003 11:50:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-05-14 at 09:30, Dean McEwan wrote:
>     I had an idea for DRM, what about a kernel that forces everything downloaded to have a 
> valid signature, and doesn't let the file/program be accessed otherwise?

You can set this up with both rsbac and selinux

