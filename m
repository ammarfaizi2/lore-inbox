Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262238AbUBXM0a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 07:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262239AbUBXM0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 07:26:30 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:23968 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262238AbUBXM03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 07:26:29 -0500
Date: Tue, 24 Feb 2004 13:26:28 +0100
From: Jan Kara <jack@suse.cz>
To: Philippe Troin <phil@fifi.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Quota compilation fix
Message-ID: <20040224122628.GA2780@atrey.karlin.mff.cuni.cz>
References: <87isi133wq.fsf@ceramic.fifi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87isi133wq.fsf@ceramic.fifi.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Enclosed patch allows kernel compilation when CONFIG_QFMT_V2=y.
  It looks like you have wrongly patched kernel - I don't see the
DQUOT_SYNC() call in my 2.4.25 tree...

							Honza


-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
