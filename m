Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262330AbRENRO5>; Mon, 14 May 2001 13:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262334AbRENROr>; Mon, 14 May 2001 13:14:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8972 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262330AbRENROk>;
	Mon, 14 May 2001 13:14:40 -0400
Date: Mon, 14 May 2001 18:13:57 +0100
From: Joel Becker <jlbec@evilplan.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>, Alex Q Chen <aqchen@us.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Minor numbers
Message-ID: <20010514181356.U6223@parcelfarce.linux.theplanet.co.uk>
Mail-Followup-To: Joel Becker <jlbec@evilplan.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Rogier Wolff <R.E.Wolff@BitWizard.nl>,
	Alex Q Chen <aqchen@us.ibm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200105141302.PAA14005@cave.bitwizard.nl> <E14zJmj-0000p3-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14zJmj-0000p3-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, May 14, 2001 at 03:57:21PM +0100
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2001 at 03:57:21PM +0100, Alan Cox wrote:
> > > 20:12 is more common
> > 
> > Which is major, which is minor?
> 
> 20bit major

	Well, AIX 4.3 (and 4.[12] I think as well) uses 16:16, and they
are preparing for 32:32 when the kernel finaly goes fully 64-bit.  I
don't know enough about AIX 5.1 to know if they really did that or
backed down on their promise (The kernel guys told me two years ago that
they were going to push the full 64-bit migration, but I haven't heard
anything since).

Joel

-- 

"We'd better get back, `cause it'll be dark soon,
 and they mostly come at night.  Mostly."

			http://www.jlbec.org/
			jlbec@evilplan.org
