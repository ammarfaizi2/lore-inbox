Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262348AbTFFWnj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 18:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbTFFWnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 18:43:39 -0400
Received: from almesberger.net ([63.105.73.239]:24074 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S262348AbTFFWni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 18:43:38 -0400
Date: Fri, 6 Jun 2003 19:56:49 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Mitchell Blank Jr <mitch@sfgoth.com>
Cc: "David S. Miller" <davem@redhat.com>, chas@cmf.nrl.navy.mil,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations (take 2)
Message-ID: <20030606195649.E3232@almesberger.net>
References: <20030606121339.A3232@almesberger.net> <20030606.081618.108808702.davem@redhat.com> <20030606122616.B3232@almesberger.net> <20030606.082802.124082825.davem@redhat.com> <20030606125416.C3232@almesberger.net> <20030606214317.GD21217@gaz.sfgoth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030606214317.GD21217@gaz.sfgoth.com>; from mitch@sfgoth.com on Fri, Jun 06, 2003 at 02:43:17PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mitchell Blank Jr wrote:
> ATM switch and have atmsigd speak NNI to its neighbors (didn't someone have
> some code for this WAY back in the dark ages... but it had some unfortunate
> license issues... or am I remembering wrong?)

I think it was Ascom who had some P-NNI code, but they never
made the effort of clearing it for release, even though it
was only gathering dust in some drawer.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
