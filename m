Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273298AbTG3TN5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 15:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273316AbTG3TN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 15:13:57 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:13745 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S273298AbTG3TLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 15:11:45 -0400
Date: Wed, 30 Jul 2003 15:11:38 -0400
From: Bill Nottingham <notting@redhat.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Tomas Szepe <szepe@pinerecords.com>, Bas Mevissen <ml@basmevissen.nl>,
       Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>,
       linux-kernel@vger.kernel.org
Subject: Re: module-init-tools don't support gzipped modules.
Message-ID: <20030730151138.B6461@devserv.devel.redhat.com>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	Tomas Szepe <szepe@pinerecords.com>,
	Bas Mevissen <ml@basmevissen.nl>,
	Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>,
	linux-kernel@vger.kernel.org
References: <20030730101518.GL4279@louise.pinerecords.com> <20030730183635.0B82D2C097@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030730183635.0B82D2C097@lists.samba.org>; from rusty@rustcorp.com.au on Thu, Jul 31, 2003 at 02:46:23AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell (rusty@rustcorp.com.au) said: 
> I agree, but I believe almost anything is a valid feature request.
> 
> I don't want to require zlib, though.  The modutils I have (Debian)
> doesn't support it, either.
> 
> It's fairly trivial patch, which probably is best as an add-on (which
> I think RH do?

No, we don't add on gzipped module support for module-init-tools.

Bill
