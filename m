Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270990AbRIJOsi>; Mon, 10 Sep 2001 10:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270992AbRIJOs2>; Mon, 10 Sep 2001 10:48:28 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:36100 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S270990AbRIJOsY>; Mon, 10 Sep 2001 10:48:24 -0400
Date: Mon, 10 Sep 2001 16:48:13 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Raghava Raju <vraghava_raju@yahoo.com>
Cc: kernelnewbies@nl.linux.org, kernel-doc@nl.linux.org,
        linux-kernel@vger.kernel.org
Subject: Re: create_proc_entry
Message-ID: <20010910164813.B1253@arthur.ubicom.tudelft.nl>
In-Reply-To: <20010906205153.92503.qmail@web20004.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010906205153.92503.qmail@web20004.mail.yahoo.com>; from vraghava_raju@yahoo.com on Thu, Sep 06, 2001 at 01:51:53PM -0700
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2001 at 01:51:53PM -0700, Raghava Raju wrote:
>     I want to know about the the
> call "create_proc_entry". What exactly it does.   
> Once created how does user make use of it. What are
> the interfaces to it for user to communicate with it.
> Any documents related to above things will be
> helpful.

It's all documented in the Procfs Guide:

- Run "make psdocs" in your kernel tree and you'll get the file
  Documentation/DocBook/procfs-guide.ps
- Get the PDF version from http://www.kernelnewbies.org/documents/


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
