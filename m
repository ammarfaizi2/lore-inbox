Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264172AbTDJU6G (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 16:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264173AbTDJU6G (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 16:58:06 -0400
Received: from pcp701542pcs.bowie01.md.comcast.net ([68.50.82.18]:25551 "EHLO
	lucifer.gotontheinter.net") by vger.kernel.org with ESMTP
	id S264172AbTDJU6F (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 16:58:05 -0400
Subject: Re: glibc+sysenter sources..?
From: Disconnect <lkml@sigkill.net>
To: Steven Cole <elenstev@mesatop.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1050008432.24463.69.camel@spc9.esa.lanl.gov>
References: <1049913600.18782.24.camel@sparky>
	 <20030409211042.GA29819@nevyn.them.org>  <1049998110.1263.50.camel@sparky>
	 <1050008432.24463.69.camel@spc9.esa.lanl.gov>
Content-Type: text/plain
Organization: 
Message-Id: <1050008778.4629.63.camel@sparky>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 10 Apr 2003 17:06:18 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-04-10 at 17:00, Steven Cole wrote:
> On Thu, 2003-04-10 at 12:08, Disconnect wrote:
> > On Wed, 2003-04-09 at 17:10, Daniel Jacobowitz wrote:
> > > On Wed, Apr 09, 2003 at 02:40:00PM -0400, Disconnect wrote:
> > > > I found the binaries (ftp://people.redhat.com/drepper/glibc/2.3.1-25/)
> > > > but the sources don't seem to be available.
> > Since the binaries are being distributed there, I had expected to find
> > sources in the same place.. or at least -somewhere-..
> 
> Try here: ftp://ftp.gnu.org/gnu/glibc/

That would be the sources to the original 2.3.1 or 2.3.2 (depending).
That would -not- be the sources to
ftp://people.redhat.com/drepper/glibc/2.3.1-25/*.rpm, which is a
derivative version.  Shall we play the GPL game? The bins were
distribute to me (they're sitting on the machine in question) with no
sources available.  

C'mon people, enough with the obvious/troll/etc .. if you don't have the
source or patches used to generate those bins (and you don't know where
to get them) then its a safe bet that I'm not talking to you....

(And fwiw, I did find parts of them by spending a few hours curled up
with the glibc cvs list archive, changelog, etc. But - as has been noted
in the various B*K* flamewars - cvs does a really horrid job of
changeset management.. its even more entertaining when you try to use
cvsweb to extact them..)

-- 
Disconnect <lkml@sigkill.net>

