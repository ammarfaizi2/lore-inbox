Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132718AbRDXC5V>; Mon, 23 Apr 2001 22:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132725AbRDXC5C>; Mon, 23 Apr 2001 22:57:02 -0400
Received: from hilbert.umkc.edu ([134.193.4.60]:18194 "HELO tesla.umkc.edu")
	by vger.kernel.org with SMTP id <S132718AbRDXC4x>;
	Mon, 23 Apr 2001 22:56:53 -0400
Message-ID: <3AE4EAEA.26F37BEB@kasey.umkc.edu>
Date: Mon, 23 Apr 2001 21:54:34 -0500
From: "David L. Nicol" <david@kasey.umkc.edu>
Organization: University of Missouri - Kansas City   supercomputing infrastructure
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Dale Amon <amon@vnl.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Idea: Encryption plugin architecture for file-systems
In-Reply-To: <NFBBIDPOFIIFCBDDFGLEGEMICCAA.nagytam@rerecognition.com> <01042121404701.08246@antares> <20010423211237.I26083@vnl.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dale Amon wrote:
> 
> Talk about syncronicity... I had just last week asked
> about the pro's and con's on this on the crypto list and
> have heard nothing at all back. So I'll drop the body
> of that message in here:


why not port one of the twenty or thirty preexisting tools
that let you mount a filesystem from an encrypted file instead
of making a generic layer?  That way you could have inter-os 
portability.  The steganographic ones make really impressive
claims.  

Does linux have a truly generic plug-in file system module yet,
or are people still hacking around fake nfs servers? 




-- 
                      David Nicol 816.235.1187 dnicol@cstp.umkc.edu
                                    "Described as awesome by users"

