Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbTENGN6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 02:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbTENGN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 02:13:58 -0400
Received: from tantale.fifi.org ([216.27.190.146]:14464 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id S262033AbTENGN5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 02:13:57 -0400
To: linux-kernel@vger.kernel.org
Cc: "Justin T. Gibbs" <gibbs@scsiguy.com>
Subject: Re: Cryptic SCSI error messages
References: <87el325o2x.fsf@ceramic.fifi.org>
Mail-Copies-To: nobody
From: Philippe Troin <phil@fifi.org>
Date: 13 May 2003 23:26:42 -0700
In-Reply-To: <87el325o2x.fsf@ceramic.fifi.org>
Message-ID: <87of26xcv1.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philippe Troin <phil@fifi.org> writes:

>   * The problem.
> 
>       1. The SCSI subsystem craps out a cryptic message:
> 
>           SCSI disk error : host 0 channel 0 id 2 lun 0 return code = 10000
>           I/O error: dev 08:20, sector 32932328
> 
>          It's always "return code = 10000" and the problem always
>          happens with disk 0/0/2/0.

Update: The disk died tonight, it does not answer anymore at all at
the bus reset. I guess that explains it all.

Sorry for the noise,
Phil.

