Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267179AbUHVNck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267179AbUHVNck (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 09:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267184AbUHVNck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 09:32:40 -0400
Received: from poros.telenet-ops.be ([195.130.132.44]:44510 "EHLO
	poros.telenet-ops.be") by vger.kernel.org with ESMTP
	id S267179AbUHVNcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 09:32:35 -0400
From: Karl Vogel <karl.vogel@seagha.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.8.1: swap storm of death
Date: Sun, 22 Aug 2004 15:33:14 +0200
User-Agent: KMail/1.6.2
References: <200408221527.10303.karl.vogel@seagha.com>
In-Reply-To: <200408221527.10303.karl.vogel@seagha.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408221533.14666.karl.vogel@seagha.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 22 August 2004 15:27, Karl Vogel wrote:

> The diagnostics can be found here:

Forgot one:

* ps ax - after OOM kill
  http://users.telenet.be/kvogel/ps.txt
