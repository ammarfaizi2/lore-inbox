Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262761AbTJ3TJS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 14:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262782AbTJ3TJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 14:09:18 -0500
Received: from walker.svs.informatik.uni-oldenburg.de ([134.106.22.19]:59016
	"EHLO walker.pmhahn.de") by vger.kernel.org with ESMTP
	id S262761AbTJ3TJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 14:09:02 -0500
Date: Thu, 30 Oct 2003 20:08:29 +0100
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Post-halloween doc updates.
Message-ID: <20031030190829.GB21742@titan.lahn.de>
Mail-Followup-To: Philipp Matthias Hahn <pmhahn@titan.lahn.de>,
	Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20031030141519.GA10700@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031030141519.GA10700@redhat.com>
Organization: UUCP-Freunde Lahn e.V.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave, LKML!

On Thu, Oct 30, 2003 at 02:15:19PM +0000, Dave Jones wrote:
>                      The post-halloween document. v0.46
...
> Input layer.
...
> - If you find your keyboard/mouse still don't work, edit the file
>   drivers/input/serio/i8042.c, and replace the #undef DEBUG
>   with a #define DEBUG
                        , recompile and reinstall.
> 
>   When you boot, you should now see a lot more debugging information.
>   Forward this information to Vojtech Pavlik <vojtech@suse.cz>

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de
