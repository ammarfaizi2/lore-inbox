Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbWIDJ1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbWIDJ1b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 05:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWIDJ1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 05:27:31 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57029 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751169AbWIDJ13 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 05:27:29 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060903220657.GG4416@stusta.de> 
References: <20060903220657.GG4416@stusta.de> 
To: Adrian Bunk <bunk@stusta.de>
Cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: frv compile error in set_pte() 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Mon, 04 Sep 2006 10:26:25 +0100
Message-ID: <14367.1157361985@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:

> I'm getting the follosing compile error in 2.6.18-rc5-mm1 (it might not 
> be specific to -mm):

Does your compiler support the 'M' and 'U' constraint modifiers on FRV?

David

-- 
VGER BF report: H 0
