Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268031AbUJDLtj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268031AbUJDLtj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 07:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268035AbUJDLti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 07:49:38 -0400
Received: from build.arklinux.osuosl.org ([128.193.0.51]:44516 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S268031AbUJDLtD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 07:49:03 -0400
From: Bernhard Rosenkraenzer <bero@arklinux.org>
Organization: LINUX4MEDIA GmbH
To: mocm@mocm.de
Subject: Re: Efficeon
Date: Mon, 4 Oct 2004 13:45:27 +0200
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <16735.62032.169017.247720@mocm.de>
In-Reply-To: <16735.62032.169017.247720@mocm.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410041345.27682.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 03 October 2004 14:36, Marcus Metzler wrote:
> Hi,
>
> I was just wondering which CPU options I should choose for compiling a
> kernel for an Efficeon?
> Crusoe seems to work fine.

Crusoe works, but doesn't give you all the features of the Efficeon CPU 
(Crusoe doesn't have SSE and friends AFAIR). You may want to try Pentium4.

LLaP
bero
