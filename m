Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287044AbSABW3O>; Wed, 2 Jan 2002 17:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287115AbSABW2i>; Wed, 2 Jan 2002 17:28:38 -0500
Received: from dot.cygnus.com ([205.180.230.224]:2571 "HELO dot.cygnus.com")
	by vger.kernel.org with SMTP id <S287102AbSABW12>;
	Wed, 2 Jan 2002 17:27:28 -0500
Date: Wed, 2 Jan 2002 14:27:12 -0800
From: Richard Henderson <rth@redhat.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Momchil Velikov <velco@fadata.bg>, linux-kernel@vger.kernel.org,
        gcc@gcc.gnu.org, linuxppc-dev@lists.linuxppc.org,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020102142712.B10474@redhat.com>
Mail-Followup-To: Richard Henderson <rth@redhat.com>,
	Tom Rini <trini@kernel.crashing.org>,
	Momchil Velikov <velco@fadata.bg>, linux-kernel@vger.kernel.org,
	gcc@gcc.gnu.org, linuxppc-dev@lists.linuxppc.org,
	Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
	Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Corey Minyard <minyard@acm.org>
In-Reply-To: <87g05py8qq.fsf@fadata.bg> <20020102190910.GG1803@cpe-24-221-152-185.az.sprintbbd.net> <20020102133632.C10362@redhat.com> <20020102220548.GL1803@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020102220548.GL1803@cpe-24-221-152-185.az.sprintbbd.net>; from trini@kernel.crashing.org on Wed, Jan 02, 2002 at 03:05:48PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2002 at 03:05:48PM -0700, Tom Rini wrote:
> Well, the problem is that we aren't running where the compiler thinks we
> are yet.  So what would the right fix be for this?

Assembly.


r~
