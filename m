Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267518AbUHRTJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267518AbUHRTJz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 15:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267536AbUHRTJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 15:09:55 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:18233 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S267518AbUHRTJx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 15:09:53 -0400
Date: Wed, 18 Aug 2004 23:10:00 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Coywolf Qi Hunt <coywolf@greatcn.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, akpm@osdl.org, kai@tp1.ruhr-uni-bochum.de,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] remove obsolete HEAD in kbuild
Message-ID: <20040818211000.GA21714@mars.ravnborg.org>
Mail-Followup-To: Coywolf Qi Hunt <coywolf@greatcn.org>,
	Sam Ravnborg <sam@ravnborg.org>, akpm@osdl.org,
	kai@tp1.ruhr-uni-bochum.de, linux-kernel@vger.kernel.org
References: <411F3A48.2030201@greatcn.org> <20040815174915.GA7265@mars.ravnborg.org> <412016AA.6030006@greatcn.org> <20040816205230.GA21047@mars.ravnborg.org> <41218562.9040204@greatcn.org> <20040817211258.GA20246@mars.ravnborg.org> <4122E477.4010601@greatcn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4122E477.4010601@greatcn.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2004 at 01:09:11PM +0800, Coywolf Qi Hunt wrote:
> 
> Makefile: remove obsolete HEAD
> arch/cris/Makefile: replace HEAD with assignment to head-y

Thanks, applied.

	Sam
