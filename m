Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287069AbSABWhE>; Wed, 2 Jan 2002 17:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287113AbSABWgs>; Wed, 2 Jan 2002 17:36:48 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:47235
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S287106AbSABWgR>; Wed, 2 Jan 2002 17:36:17 -0500
Date: Wed, 2 Jan 2002 15:35:57 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Richard Henderson <rth@redhat.com>, Momchil Velikov <velco@fadata.bg>,
        linux-kernel@vger.kernel.org, gcc@gcc.gnu.org,
        linuxppc-dev@lists.linuxppc.org,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020102223557.GM1803@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <87g05py8qq.fsf@fadata.bg> <20020102190910.GG1803@cpe-24-221-152-185.az.sprintbbd.net> <20020102133632.C10362@redhat.com> <20020102220548.GL1803@cpe-24-221-152-185.az.sprintbbd.net> <20020102142712.B10474@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020102142712.B10474@redhat.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2002 at 02:27:12PM -0800, Richard Henderson wrote:
> On Wed, Jan 02, 2002 at 03:05:48PM -0700, Tom Rini wrote:
> > Well, the problem is that we aren't running where the compiler thinks we
> > are yet.  So what would the right fix be for this?
> 
> Assembly.

That's not really an option.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
