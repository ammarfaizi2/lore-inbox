Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270367AbTHLN67 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 09:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270370AbTHLN67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 09:58:59 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:918
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S270367AbTHLN6x convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 09:58:53 -0400
From: Con Kolivas <kernel@kolivas.org>
To: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns?=
	=?iso-8859-1?q?=20Rullg=E5rd?=),
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]O15int for interactivity
Date: Wed, 13 Aug 2003 00:04:32 +1000
User-Agent: KMail/1.5.3
References: <200308122226.11557.kernel@kolivas.org> <yw1xekzr9hn9.fsf@users.sourceforge.net>
In-Reply-To: <yw1xekzr9hn9.fsf@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200308130004.32589.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Aug 2003 22:36, Måns Rullgård wrote:
> Con Kolivas <kernel@kolivas.org> writes:
> > Patch against 2.6.0-test3-mm1:
>
> I'd appreciate patches against the previous version, in this case
> O14.1, as well as the full patch.  Would this require much work?

2.6.0-test3-mm1 already contains O14.1

Other split patches can be found here:

http://kernel.kolivas.org/2.5

The split patches for >O14 on test3 vanilla do not work at the moment I'm 
afraid. It is much easier to maintain the patches against the one tree.

Con

