Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966108AbWKNQ03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966108AbWKNQ03 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 11:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755443AbWKNQ03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 11:26:29 -0500
Received: from sardaukar.technologeek.org ([213.41.134.240]:17087 "EHLO
	frigate.technologeek.org") by vger.kernel.org with ESMTP
	id S1755430AbWKNQ03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 11:26:29 -0500
From: Julien BLACHE <jb@jblache.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: jgarzik@pobox.com, jhf@columbus.rr.com
Subject: Re: Intel RNG: firmware hub changes in 2.6.19 break 82802 detection on Core2 Duo MacBook Pro
References: <87u015osxb.fsf@frigate.technologeek.org>
	<20061113191205.GA15349@nineveh.rivenstone.net>
Date: Tue, 14 Nov 2006 17:26:29 +0100
In-Reply-To: <20061113191205.GA15349@nineveh.rivenstone.net> (Joseph Fannin's
	message of "Mon, 13 Nov 2006 14:12:05 -0500")
Message-ID: <87d57qq9je.fsf@frigate.technologeek.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jhf@columbus.rr.com (Joseph Fannin) wrote:

Hi,

>     I have the older Core Duo MacBook, and there is no RNG here,
> though it used to be detected.  rngd would disable it immediately when
> I tried to use it.

That's what happens here too.

Thanks for the input, looks like there isn't a hardware RNG in there.

JB.

-- 
Julien BLACHE                                   <http://www.jblache.org> 
<jb@jblache.org>                                  GPG KeyID 0xF5D65169
