Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129608AbRBWKjM>; Fri, 23 Feb 2001 05:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129724AbRBWKjC>; Fri, 23 Feb 2001 05:39:02 -0500
Received: from sith.mimuw.edu.pl ([193.0.97.1]:12039 "HELO sith.mimuw.edu.pl")
	by vger.kernel.org with SMTP id <S129608AbRBWKiz>;
	Fri, 23 Feb 2001 05:38:55 -0500
Date: Fri, 23 Feb 2001 11:42:49 +0100
From: Jan Rekorajski <baggins@sith.mimuw.edu.pl>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [UPDATE] zerocopy BETA 3
Message-ID: <20010223114249.A27608@sith.mimuw.edu.pl>
Mail-Followup-To: Jan Rekorajski <baggins@sith.mimuw.edu.pl>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
	netdev@oss.sgi.com
In-Reply-To: <14998.2628.144784.585248@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <14998.2628.144784.585248@pizda.ninka.net>; from davem@redhat.com on Thu, Feb 22, 2001 at 10:59:16PM -0800
X-Operating-System: Linux 2.4.2-pre4 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Feb 2001, David S. Miller wrote:

> 
> Usual spot:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/davem/zerocopy-2.4.2-2.diff.gz
> 
> Changes since last installment:
> 
> 3) Workaround for win2000/95 VJ header compression bugs is
>    implemented.

Could you please make a patch with this fix only? Or is it available
somewhere?

Jan
-- 
Jan Rêkorajski            |  ALL SUSPECTS ARE GUILTY. PERIOD!
baggins<at>mimuw.edu.pl   |  OTHERWISE THEY WOULDN'T BE SUSPECTS, WOULD THEY?
BOFH, MANIAC              |                   -- TROOPS by Kevin Rubio
