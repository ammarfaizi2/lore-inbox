Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263082AbUAOO00 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 09:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262746AbUAOO00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 09:26:26 -0500
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:36727 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263082AbUAOO0Z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 09:26:25 -0500
From: Murilo Pontes <murilo_pontes@yahoo.com.br>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [BUG] ABNT2 keyboards not work with >= 2.6.1 with or without -mm patchs
Date: Thu, 15 Jan 2004 11:26:02 +0000
User-Agent: KMail/1.5.94
References: <200401142326.21543.murilo_pontes@yahoo.com.br> <20040115072411.GA526@ucw.cz>
In-Reply-To: <20040115072411.GA526@ucw.cz>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200401151126.02722.murilo_pontes@yahoo.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I try 2.6.1-mm3 still not working



Em Qui 15 Jan 2004 07:24, você escreveu:
> On Wed, Jan 14, 2004 at 11:26:21PM +0000, Murilo Pontes wrote:
> > BUG: ABNT2 keyboards not work with >= 2.6.1 with or without -mm patchs
> > DESCRIPTION: The "/ ?" not work on console-framebuffer
>
> Known problem. They should work with recent -mm (if Andrew applied my
> patch), and that patch should go to 2.6.2 soon. Please test if it works
> correctly with latest -mm kernel.
