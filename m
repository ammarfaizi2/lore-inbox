Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272442AbTGaJRo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 05:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272873AbTGaJRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 05:17:44 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:24732 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S272442AbTGaJRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 05:17:43 -0400
Date: Thu, 31 Jul 2003 11:17:23 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Bas Mevissen <ml@basmevissen.nl>,
       Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>,
       linux-kernel@vger.kernel.org
Subject: Re: module-init-tools don't support gzipped modules.
Message-ID: <20030731091723.GJ12849@louise.pinerecords.com>
References: <20030730101518.GL4279@louise.pinerecords.com> <20030730183635.0B82D2C097@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030730183635.0B82D2C097@lists.samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't want to require zlib, though.  The modutils I have (Debian)
> doesn't support it, either.

Well, if you decide to implement zlib support, let's have it optional
just like it is in modutils.

-- 
Tomas Szepe <szepe@pinerecords.com>
