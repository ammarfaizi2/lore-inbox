Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264709AbTF0Tnp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 15:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264722AbTF0Tnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 15:43:45 -0400
Received: from cs180094.pp.htv.fi ([213.243.180.94]:2944 "EHLO hades.pp.htv.fi")
	by vger.kernel.org with ESMTP id S264709AbTF0Tno (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 15:43:44 -0400
Subject: Re: TCP send behaviour leads to cable modem woes
From: Mika Liljeberg <mika.liljeberg@welho.com>
To: Svein Ove Aas <svein.ove@aas.no>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200306272145.22008.svein.ove@aas.no>
References: <200306272020.57502.svein.ove@aas.no>
	 <1056740526.645.2.camel@hades>  <200306272145.22008.svein.ove@aas.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1056743877.681.5.camel@hades>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 27 Jun 2003 22:57:57 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-06-27 at 22:45, Svein Ove Aas wrote:
> Incidentally, while googling I heard someone saying that only works if it's 
> enabled on both ends? Of course, that might be if upload/download are 'both' 
> affected, in which case it wouldn't apply to me.

It's a sender side only algorithm, so enabling it at your end should be
enough to help the uploads. For downloads it needs to be on at the other
end, of course.

	MikaL

