Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271191AbTGPW5r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 18:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271204AbTGPW5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 18:57:46 -0400
Received: from ip67-95-245-82.z245-95-67.customer.algx.net ([67.95.245.82]:1286
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S271191AbTGPWza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 18:55:30 -0400
Date: Wed, 16 Jul 2003 16:10:29 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6 sound drivers?
Message-ID: <20030716231029.GG1821@matchmail.com>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
References: <20030716225826.GP2412@rdlg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716225826.GP2412@rdlg.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 06:58:26PM -0400, Robert L. Harris wrote:
> 
> 
> I have a soundblaster Live.  I've historically used the OSS drivers as
> they've worked well for me.  I just tried to load the emu10k1 which
> loads without error, but mpg123 says it can't open the default sound
> device.
> 
> Anyone able to do an lsmod or a listing of the drivers I need for an
> SBLive?

Did you install alsa-utils?
