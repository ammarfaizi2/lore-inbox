Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269509AbTG3KPj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 06:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270007AbTG3KPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 06:15:39 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:13207 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S269661AbTG3KPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 06:15:38 -0400
Date: Wed, 30 Jul 2003 12:15:18 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Bas Mevissen <ml@basmevissen.nl>
Cc: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>,
       linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: module-init-tools don't support gzipped modules.
Message-ID: <20030730101518.GL4279@louise.pinerecords.com>
References: <20030730062245.382c5dad.vmlinuz386@yahoo.com.ar> <3F2799B3.3020109@basmevissen.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F2799B3.3020109@basmevissen.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [ml@basmevissen.nl]
> 
> >The possibility of compressing the modules is interesting, like for
> >example in cases of construction of small systems or initrd.
> 
> In both cases, you might use a compressed file system. Maybe you better 
> try to save memory and disk space by compressing less critical stuff 
> than kernel modules.

It's a valid feature request nonetheless.

-- 
Tomas Szepe <szepe@pinerecords.com>
