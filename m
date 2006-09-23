Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750999AbWIWJvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbWIWJvh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 05:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbWIWJvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 05:51:37 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:50601 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750999AbWIWJvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 05:51:37 -0400
Subject: Re: [PATCH 2.6.18] [TRIVIAL] Spelling fixes in
	Documentation/DocBook
From: David Woodhouse <dwmw2@infradead.org>
To: Michael Opdenacker <michael-lists@free-electrons.com>
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org
In-Reply-To: <200609212318.07418.michael-lists@free-electrons.com>
References: <200609212318.07418.michael-lists@free-electrons.com>
Content-Type: text/plain; charset=UTF-8
Date: Sat, 23 Sep 2006 10:51:12 +0100
Message-Id: <1159005072.24527.891.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-21 at 23:18 +0200, Michael Opdenacker wrote:
> -and associated transciever to support <emphasis>Dual-Role</emphasis>
> +and associated transceiver to support <emphasis>Dual-Role</emphasis> 

Since you're actually touching this line already, could you not fix
'Role' to 'Rôle'? If you fix the aspell config it ought to catch that
error too.

Our computers became capable of more than just ASCII text some years ago
-- there's no real excuse for dropping accents any more.

-- 
dwmw2

