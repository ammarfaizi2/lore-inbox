Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbVEIMPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbVEIMPx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 08:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbVEIMPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 08:15:53 -0400
Received: from relay1.tiscali.de ([62.26.116.129]:59614 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S261314AbVEIMPo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 08:15:44 -0400
Message-ID: <427F5469.5000304@tiscali.de>
Date: Mon, 09 May 2005 14:15:37 +0200
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Kristian_S=F8rensen?= <ks@linnovative.dk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Any work in implementing Secure IPC for Linux?
References: <200505091111.24130.ks@linnovative.dk>
In-Reply-To: <200505091111.24130.ks@linnovative.dk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kristian Sørensen wrote:
> Hi!
> 
> Does anyone here know of work being done in order to implement secure IPC for 
> Linux?
> 
> Anyone that have some ideas for how this could be done?
> 
> 
> Best regards,
> Kristian Sørensen.
> 
> 
Linux uses the System V IPC, maybe a switch to a IPC like the one used in 
the gnu match microkernel is more secure and comfortable. The port concept 
is very interesting, becuase it has access rights.

Matthias-Christian Ott
